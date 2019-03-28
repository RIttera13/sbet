class PatientsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
    Patient,
    params[:filterrific],
    select_options: {
      }
    ) or return

    @patients = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @filterrific.find.to_csv }
      format.xls { send_data @filterrific.find.to_csv(col_sep: "\t") }
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
     puts "Had to reset filterrific params: #{ e.message }"
     redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def new
    @patient = Patient.new
    @patient.build_allergy
    @patient.build_admission
    @medication_order = @patient.medication_orders.build
    @medication_order.build_order_frequency

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @patient = Patient.new(patient_params)
    binding.pry
    if @patient.save
      flash[:notice] = "Emergency Transfer Summary (Form 34L-D) for #{patient_params[:first_name]} #{patient_params[:last_name]} Has Been Created"
      redirect_to patients_path
    else
      flash.now[:alert] = "There Was An Error Creating The Transfer. Please Try Again."
      redirect_to patients_path
    end
  end

  def show
    @patient = Patient.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    @patient.build_allergy
    @patient.build_admission
    @patient.build_medication_order
  end

  def update
    @patient = Patient.find(params[:id])

    @patient.assign_attributes(patient_params)

    if @patient.save
      flash[:notice] = "Transfer for #{patient_params[:first_name]} #{patient_params[:last_name]} Has Been Updated."
      redirect_to patients_path
    else
      flash.now[:alert] = "Error Updating Transfer. Please Try Again."
      redirect_to patients_path
    end
  end

  def destroy
    @patient = Patient.find(params[:id])

    if @patient.destroy
      flash[:notice] = "Transfer Was Deleted Succesfully."
      redirect_to patients_path
    end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :first_name, :middle_name, :last_name, :mr, :dob, :gender,
      allergy_attributes: Allergy.attribute_names.map(&:to_sym).push(:_destroy),
      admission_attributes: Admission.attribute_names.map(&:to_sym).push(:_destroy),
      medication_orders_attributes: MedicationOrder.attribute_names.map(&:to_sym).push(:order_frequency_attributes => [:value, :unit]).push(:_destroy)
    )
  end
end
