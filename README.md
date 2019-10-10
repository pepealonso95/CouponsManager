CouponManager


CouponManager consiste en brindar un servicio que permita la creación, gestión y trazabilidad de cupones promocionales y descuentos, pudiendo ser gestionados desde un mismo lugar. Es decir, dado un cupón de un compañía ofrezca el sistema deberá validar si el cupón es válido y si además cumple con las reglas para que sea aplicado. A su vez, el sistema también deberá poder aplicar descuentos en tiempo real dadas ciertas condiciones en el proceso de compra de una plataforma online, como si la compra supera cierto monto, y cantidad de ítems entonces se aplica el descuento.

Para importar el proyecto a su ambiente de desarrollo:

Clonar el proyecto del repositorio git

crear un usuario y base de datos en postgres

Crear un archivo local_env.yml y configurar las siguientes variables de entorno:
MAIL_USERNAME: *cuenta de gmail que enviara los correos del sistema*
MAIL_PASSWORD: *contrasena de cuenta de gmail*
REDIS_USER: *usuario de redisLabs*
REDIS_PASSWORD: *contrasena de redisLabs*
REDIS_URL: *url con la direccion del server de redisLabs*

Ejecutar comando bundle install

Dependencias

gem 'rails', '~> 6.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'redis'
gem 'devise'
gem 'jwt'
gem 'rspec-rails'
gem 'factory_bot_rails'
gem "database_cleaner"
gem 'jquery-rails'
gem 'figaro'
gem "paperclip", "~> 6.0.0"
gem 'aws-sdk', '~> 2.3'
gem 'paperclip-cloudinary'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'web-console', '>= 3.3.0'
gem 'listen', '>= 3.0.5', '< 3.2'
gem 'spring'
gem 'spring-watcher-listen', '~> 2.0.0'
gem 'capybara'
gem 'selenium-webdriver'  
gem 'webdrivers'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "acts_as_tenant", "~> 0.4.4"


Autores
Nicolas Damiani, 192489
Rafael Alonso, 201523
Sebastian Rodriguez, 192412
