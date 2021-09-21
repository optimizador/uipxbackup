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
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  #urlapi="http://localhost:8080"

  #parametros recibidos
  logger.info("llamado api:" )
  logger.info("#{urlapi}/api/lvl2/pxbackupsol?almacenamientogb=#{almacenamientogb}&rsemanal=#{rsemanal}&rsemanalretencion=#{rsemanalretencion}&rdiario=#{rdiario}&rdiarioretencion=#{rdiarioretencion}&rmensual=#{rmensual}&rmensualretencion=#{rmensualretencion}&ranual=#{ranual}&ranualretencion=#{ranualretencion}&regioncluster=#{regioncluster}&countryrespaldo=#{countryrespaldo}&resiliencybackup=#{resiliencybackup}")
  respuestasizing = RestClient.get "#{urlapi}/api/lvl2/pxbackupsol?almacenamientogb=#{almacenamientogb}&rsemanal=#{rsemanal}&rsemanalretencion=#{rsemanalretencion}&rdiario=#{rdiario}&rdiarioretencion=#{rdiarioretencion}&rmensual=#{rmensual}&rmensualretencion=#{rmensualretencion}&ranual=#{ranual}&ranualretencion=#{ranualretencion}&regioncluster=#{regioncluster}&countryrespaldo=#{countryrespaldo}&resiliencybackup=#{resiliencybackup}", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  erb :pxbackup , :locals => {:respuestasizing => respuestasizing}
end



get '/pxbackupyent' do
  logger = Logger.new(STDOUT)
  logger.info("Selecciono dimensionamiento para solución de respaldos")
  @name = "PX-Backup"
  respuestasizing=[]
  respuestasizingalt=[]
  respuestastorage=[]
  response.set_cookie("llave2", value: "valor2")
    erb :pxbackupyent , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestastorage => respuestastorage}
end

get '/pxbackupyentrespuesta' do

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
    "diff: "+"#{params['diff']}"+
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
  diff="#{params['diff']}"
  @name = "PX-Backup"
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  #urlapi="http://localhost:8080"

  if diff==""
    diff=100
  end

  #parametros recibidos
  callapi="#{urlapi}/api/lvl2/pxbackupsol_pxent?almacenamientogb=#{almacenamientogb}&rsemanal=#{rsemanal}&rsemanalretencion=#{rsemanalretencion}&rdiario=#{rdiario}&rdiarioretencion=#{rdiarioretencion}&rmensual=#{rmensual}&rmensualretencion=#{rmensualretencion}&ranual=#{ranual}&ranualretencion=#{ranualretencion}&regioncluster=#{regioncluster}&countryrespaldo=#{countryrespaldo}&resiliencybackup=#{resiliencybackup}&diff=#{diff}"
  logger.info("llamado api:" )
  logger.info(callapi)
  respuestasizing = RestClient.get callapi, {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  erb :pxbackupyent , :locals => {:respuestasizing => respuestasizing}
end
