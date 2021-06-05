require 'sinatra'
require 'rest-client'

set :bind, '0.0.0.0'
set :port, 8090



set(:cookie_options) do
  { :expires => Time.now + 30*60 }
end

get '/' do
  logger = Logger.new(STDOUT)
  logger.info("Selecciono dimensionamiento para solución de respaldos")
  @name = "PX-Backup"
  respuestasizing=[]
  respuestasizingalt=[]
  respuestastorage=[]
  response.set_cookie("llave2", value: "valor2")
    erb :pxbackup , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestastorage => respuestastorage}
end

get '/regresar' do
  redirect "http://localhost:4567"
end

get '/respuesta' do

  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de PX-backup:" +
    "rsemanal:"+"#{params['rsemanal']}"+
    "rsemanalretencion:"+ "#{params['rsemanalretencion']}"+
    "rdiario: "+"#{params['rdiario']}"+
    "rdiarioretencion:"+"#{params['rdiarioretencion']}"+
    "rmensual: "+"#{params['rmensual']}"+
    "rmensualretencion:"+"#{params['rmensualretencion']}"+
    "ranual: "+"#{params['ranual']}"+
    "ranualretencion:"+"#{params['ranualretencion']}"+
    "regioncluster: "+"#{params['regioncluster']}"+
    "almacenamientogb:"+"#{params['almacenamientogb']}"+
    "countryrespaldo: "+"#{params['countryrespaldo']}"+
    "resiliencybackup:"+"#{params['resiliencybackup']}")


  almacenamientogb="#{params['almacenamientogb']}" #cantidad en GB
  #parametros de politicas
  rsemanal="#{params['rsemanal']}"
  rsemanalretencion="#{params['rsemanalretencion']}" #cantidad de backups retenidos
  rdiario="#{params['rdiario']}"
  rdiarioretencion="#{params['rdiarioretencion']}"#cantidad de backups retenidos
  rmensual="#{params['rmensual']}"
  rmensualretencion="#{params['rmensualretencion']}"#cantidad de backups retenidos
  ranual="#{params['ranual']}"
  ranualretencion="#{params['ranualretencion']}"#cantidad de backups retenidos
  regioncluster="#{params['regioncluster']}"#region del cluster de IKS donde se desplegará PX-Backup
  countryrespaldo = "#{params['countryrespaldo']}"
  resiliencybackup ="#{params['resiliencybackup']}"

  @name = "PX-Backup"
  #urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  urlapi="http://localhost:8080"

  #parametros recibidos
  respuestasizing = RestClient.get "#{urlapi}/api/lvl2/pxbackupsol?almacenamientogb=#{almacenamientogb}&rsemanal=#{rsemanal}&rsemanalretencion=#{rsemanalretencion}&rdiario=#{rdiario}&rdiarioretencion=#{rdiarioretencion}&rmensual=#{rmensual}&rmensualretencion=#{rmensualretencion}&ranual=#{ranual}&ranualretencion=#{ranualretencion}&regioncluster=#{regioncluster}&countryrespaldo=#{countryrespaldo}&resiliencybackup=#{resiliencybackup}", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  erb :pxbackup , :locals => {:respuestasizing => respuestasizing}
end
