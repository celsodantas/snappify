class SnapController < ApplicationController

  def index
    url = params[:url]

    log = `phantomjs #{Rails.root}/lib/snapper.js #{url} #{file_path}`
    puts log

    render :text => open(file_path, "rb").read, content_type: "image/png"
  end

  private

  def file_path
    "#{Rails.root}/tmp/myfile_#{Process.pid}.png"
  end

end
