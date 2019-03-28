class PatientsController < ApplicationController

  def new
    @allergy = Allergy.new
  end

  def create

    if allergy_params[:description].present?
      @allergy = Allergy.new(allergy_params)
    else
      @allergy = Allergy.new(description: "None")
    end

    if !@allergy.save
      raise CustomException.new(bla: "Allergies did not save correctly.")
    end
  end

  def edit
    @allergy = Allergy
  end

  def update
    @allergy = Allergy.find(params[:id])

    @allergy.assign_attributes(allergy_params)

    if !@allergy.save
      raise CustomException.new(bla: "Allergies did not update correctly.")
    end
  end

  def destroy
    @allergy = Allergy.find(params[:id])
  end

  private

  def allergy_params
    params.require(:allergy).permit(:description)
  end
end
