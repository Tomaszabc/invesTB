class Api::V1::UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    blob = ActiveStorage::Blob.create_and_upload!(io: params[:file], filename: params[:file].original_filename)
    render json: {url: url_for(blob)}
  end
end
