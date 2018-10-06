class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "api/v#{api_version.to_i}/#{path}"
  end
end

Swagger::Docs::Config.base_api_controller = ApplicationController
Swagger::Docs::Config.register_apis({
  "1.0" => {
    api_extension_type: :json,
    # the output location where your .json files are written to
    api_file_path: "public/api/v1/",
    # the URL base path to your API
    base_path: Genealogy::Settings[:url],
    # if you want to delete all .json files at each generation
    clean_directory: false,
    base_api_controller: ApplicationController
  }
})
