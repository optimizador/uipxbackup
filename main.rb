require 'sinatra'
require 'rest-client'

set :bind, '0.0.0.0'
set :port, 8090



set(:cookie_options) do
  { :expires => Time.now + 30*60 }
end

#************
#Copiar y actualizar en cada módulo
# ***Adaptar para que no se reescriban las rutas del módulo en particular donde se despliegue
#************
get '/cp4d' do
  redirect "https://ui.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/cp4d?"
  #redirect "http://localhost:8090"
end
get '/uiga' do
  redirect "https://ui-ga.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/uiga"
  #redirect "http://localhost:8090"
end
get '/loganalysis' do
  redirect "https://ui-monitoring.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/VATLA?"
  #redirect "http://localhost:8090"
end

get '/monitoring' do
  redirect "https://ui-monitoring.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/VLG?"
  #redirect "http://localhost:8090"
end

#get '/pxbackup' do
#  redirect "https://pxbackup.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
  #redirect "http://localhost:8090"
#end
get '/iks' do
  redirect "https://iks-ocp.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/iks"
end
get '/ocp' do
  redirect "https://iks-ocp.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/ocp"
end
get '/cr' do
  redirect "https://ui-cr.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
end
#************
#Fin Copiar y actualizar en cada módulo
#************

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
  redirect "https://ui.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
  #redirect "http://localhost:4567"
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
