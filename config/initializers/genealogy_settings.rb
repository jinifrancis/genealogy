Genealogy::Settings = HashWithIndifferentAccess.new(Rails.application.config_for(:'genealogy'))

def build_url
  if ![443, 80].include?(Genealogy::Settings[:port].to_i)
    custom_port = ":#{Genealogy::Settings[:port]}"
  else
    custom_port = nil
  end
  [Genealogy::Settings[:protocol],
   '://',
   Genealogy::Settings[:host],
   custom_port,
   Genealogy::Settings[:relative_url_root]].join('')
end

Genealogy::Settings[:url] = build_url

Genealogy::Settings[:authentication] ||= HashWithIndifferentAccess.new()
Genealogy::Settings[:authentication][:session_expiry_time] ||= 3600