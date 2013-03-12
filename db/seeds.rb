# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([ :name => 'Chicago' }, { :name => 'Copenhagen' ])
#   utopicus = CoworkingSpace.create(:name => 'Utopic_US', :green => 1, :yellow => 2, :red => 4)
#   6.times  |i| Table.create(:coworking_space => utopicus, :name => i+1) 

if Rails.env.development?

  User.create name: "test", email: "test@test.com", password: "123123"

  CoworkingSpace.find_or_create_by_name :name=>"Castello Centro de Negocios", :green=>6, :yellow=>8, :red=>10, :lat=>"40.4330016", :long=>" -3.6807657", :description=>"Castello Centro de Negocios es mucho mas que un centro de negocios convencional. Su magnifica ubicacion en el famoso y prestigioso barrio Salamanca (C/ Castello, 82) dotara a su negocio de ese aire de solidez y profesionalidad tan dificil de conseguir muchas veces. Con Castello Centro de Negocios no tendra que preocuparse por el mantenimiento de su oficina, pudiendo dedicar ese valioso tiempo a la gestion de su actividad, mejorando su productividad y resultados. ", :address=>"C/ Castello, 82, 5 izq"
  CoworkingSpace.find_or_create_by_name :name=>"N & N", :green=>4, :yellow=>6, :red=>8, :lat=>"40.30753", :long=>"-3.7357", :description=>"En Negocios & Networking, mediante nuestros desayunos de negocios, creamos y potenciamos grupos que funcionan como un club de empresarios, donde se establecen relaciones duraderas que permiten captar clientes, lanzar nuevos productos o realizar una presentacion de empresa, consiguiendo una amplia e inmediata difusion a traves de los asociados que, a modo de profit club, se apoyan preferiblemente entre ellos y recomiendan al resto en sus propias relaciones comerciales .\r\n\r\nEste es uno de los mejores entornos donde iniciadores , autonomos o pymes pueden expandir su negocio, solicita una invitacion a alguno de nuestros grupos y compruebalo tu mismo.", :address=>"Calle Almagro 2, primero izquierda. "
  CoworkingSpace.find_or_create_by_name :name=>"CNMadrid", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"40.428264", :long=>"-3.695264", :description=>"Centro de Negocios en Madrid CN Madrid.\r\nUna solucion para emprendedores, autonomos y PYMES. Cubre sus necesidades empresariales, tanto a nivel de sede como de servicios complementarios.\r\nEste Centro de Negocios se apoya en 3 pilares basicos:\r\nUbicacion: centrica y estrategica\r\nImagen: representativa y exclusiva\r\nEficiencia: ahorro en dinero y tiempo", :address=>"Calle Almagro 3, 28010"
  CoworkingSpace.find_or_create_by_name :name=>"Life Salud y Vida", :green=>10, :yellow=>15, :red=>18, :lat=>"40.4273", :long=>"-3.7002", :description=>"En pleno corazon de Madrid, en el barrio de Malasana (C/ Apodaca, 16), encontramos LIF(e). Un centro de terapias naturales unico en Madrid. Alli conviven el humanismo y las culturas milenarias en una perfecta simbiosis, logrando acercar el conocimiento a las personas de una forma interesante y muy divertida. Un espacio para poder vivir la calma y la tranquilidad, y sobre todo, un espacio donde las personas son la prioridad.", :address=>"C/ Apodaca, 16"
  CoworkingSpace.find_or_create_by_name :name=>"Utopicus", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"40.413866", :long=>"-3.706683", :description=>"Dos espacios modulares para generar nuevas energias, dos espacios de ideas, de colaboracion, de transformacion, de comunicacion, de innovacion y para todo tipo de eventos en el centro de Madrid.", :address=>"Calle Concepcion Jeronima 22"
  CoworkingSpace.find_or_create_by_name :name=>"Espacio \"El Manantial\"", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"20.702153", :long=>"-103.342159", :description=>"Animaros a conocer este nuevo espacio de trabajo corporal y creativo.\r\n\r\nEn unas pocas lineas quisiera expresar mi agradecimiento a las personas que estan empujando de una manera u otra para que este proyecto sea una realidad. Este acogedor, discreto, pero amable, espacio nace con el proposito de entender la naturaleza humana en su globalidad y alejar el sufrimiento de nuestras vidas, siempre sujetos a una evolucion natural como cualquier organismo vivo.\r\n\r\nAdemas de las disciplinas corporales y las propuestas creativas (Escuela de Escritura), El Manantial participa en la reintegracion social de colectivos alcoholicos a traves de programas terapeuticos de trabajo corporal en asociaciones, o programas de prevencion para jovenes y, a traves de aportaciones a la ONG Luces Rojas, colabora en la financiacion de proyectos sociales en la India y Nicaragua.\r\n\r\nJuan Carlos Diaz, Director de El Manantial.", :address=>"C/Carranza, 5, 1 Izda \r\n28004 - Madrid \r\nMetro Bilbao "
  CoworkingSpace.find_or_create_by_name :name=>"Empresarial Europea", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"40.4273", :long=>"-3.6944", :description=>"En empresarial europea encontraras un centro de negocios moderno, con mas de 1500 m2 y 2 plantas ubicado en el corazon financiero de Madrid (C/ Genova 7). Los despachos y salas permiten la conexion a Internet alta velocidad por wifi o por cable. Empresarial Europea es mas que un centro de negocios al uso, es donde los empresarios puedan conseguir clientes, aliados y mayores oportunidades de crecimiento asi como formarse en areas de interes. Su horario es de de 08:30 a 20:00 de lunes a viernes y en agosto de 08:30 a 15:00 horas.", :address=>"C/ Genova 7"
  CoworkingSpace.find_or_create_by_name :name=>"Castello Centro de Negocios", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"40.4330016", :long=>" -3.6807657", :description=>"Castello Centro de Negocios es mucho mas que un centro de negocios convencional. Su magnifica ubicacion en el famoso y prestigioso barrio Salamanca (C/ Castello, 82) dotara a su negocio de ese aire de solidez y profesionalidad tan dificil de conseguir muchas veces. Con Castello Centro de Negocios no tendra que preocuparse por el mantenimiento de su oficina, pudiendo dedicar ese valioso tiempo a la gestion de su actividad, mejorando su productividad y resultados. ", :address=>"C/ Castello, 82, 5 izq"
  CoworkingSpace.find_or_create_by_name :name=>"El garAJE - AJE Madrid", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"40.446015", :long=>"-3.673622", :description=>"El garAJE (C/ Matilde Diez, 11) es la nueva sede de la Asociacion de Jovenes Empresarios de Madrid. Un espacio de 800 m2 para dar un servicio completo con salas de reuniones, aulas de formacion, espacio de coworking (24 puestos), cafeteria, zona chill out, parking de bicis, zona peques y CAR (Centro de Alto Rendimiento). Cuenta con un aforo de 200 personas en formato teatro y hasta 350, en formato coctel. El lugar perfecto para trabajo, presentaciones o eventos.", :address=>"C/ Matilde Diez 11"
  CoworkingSpace.find_or_create_by_name :name=>"CNLagasca", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"40.4328", :long=>"-3.6846", :description=>"En pleno corazon del barrio Salamanca (C/ Lagasca, 95) encontramos el Centro de Negocios Lagasca. Un lugar dinamico y profesional a la vez que humano, en el que los trabajadores podran disponer de escritorios propios, conexion a Internet (WiFi), servicio de apoyo administrativo, atencion telefonica y salas de reuniones totalmente equipadas. El centro cuenta con: una recepcion abierta de lunes a viernes de 8.00 a 20.00, zona de espera para clientes, una terraza / jardin totalmente equipada, maquinas de vending y esta disenado para que no tenga barreras arquitectonicas.", :address=>"C/ Lagasca, 95"
  CoworkingSpace.find_or_create_by_name :name=>"Hotel La Sagrada Familia Cali (Recinto Urbano)", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"", :long=>"", :description=>"El proyecto HOTEL LA SAGRADA FAMILIA, se constituye en una plataforma urbana que recuperara un recinto de arquitectura patrimonial, es igualmente un referente urbano y afectivo de la ciudad, donde se ha proyectado un complejo arquitectonico, con un espacio de encuentro para el arte, la cultura y el entretenimiento.   \r\n\r\nEn este proyecto inmobiliario cohabitan unidades de negocio que se complementan entre si: hotel, locales comerciales, centro de bienestar, centro de entretenimiento, centro ludico y centro de convenciones. \r\n\r\nAdicionalmente, el proyecto estructuro un modelo de negocio para cada tipo de inversionista, donde es posible invertir en metros cuadrados y en la operacion de un negocio particular, proyectando una rentabilidad y una valorizacion permanente.", :address=>""
  CoworkingSpace.find_or_create_by_name :name=>"Tu Cultura", :green=>nil, :yellow=>nil, :red=>nil, :lat=>"", :long=>"", :description=>"Rutas Culturales: Una vivencia extraordinaria y divertida donde se descubre la historia y la cultura, a traves de expresiones artisticas autenticas con sentido y los sentidos: un festival de amor, sabores y colores hacia las raices afro-caribes", :address=>""

  Category.find_or_create_by_name name: 'Coworking'
  Category.find_or_create_by_name name: 'Arte y Entretenimiento'
  Category.find_or_create_by_name name: 'Restaurantes'
  Category.find_or_create_by_name name: 'Hoteles'
  Category.find_or_create_by_name name: 'Club'

  ItemCategory.find_or_create_by_name :name => "Sala de Juntas", :description => "Un espacio acogedor y profesional donde puede concretar sus negocios con facilidad."
  ItemCategory.find_or_create_by_name :name => "Salon de Conferencias", :description => "Con capacidad hasta 120 personas y dotado con la mejor tecnologia audiovisual."
  ItemCategory.find_or_create_by_name :name => "Oficinas Virtuales", :description => "\r\nTodos los beneficios de una oficina tradicional mientras usted trabaja desde cualquier lugar. \r\n\r\nEscoja el plan que mas se ajuste a sus necesidades: \r\n\tBasico \r\n\toptimo"
  ItemCategory.find_or_create_by_name :name => "Oficinas Amobladas", :description => "\r\nTenemos distintos tipos de espacios flexibles con capacidades variables.\r\n\r\nEscoja el que mas le convenga: \r\n\tEstacion de Trabajo \r\n\tFlex I \r\n\tFlex II \r\n\tGerencial\r\n\tPlus"

  coworking_space_default_image = Image.find_or_create_by_url_path url_path: "http://www.hackernest.ca/images/hackernest-toronto-coworking-space-shared-office5.jpg"
  CoworkingSpace.all.each do |coworking_space|
    coworking_space.image_ids = coworking_space_default_image.id
    coworking_space.category_id = Category.first.id
  end

  City.create(name: 'Cali', description: 'Cali', lat: '1', long: '2')

end
