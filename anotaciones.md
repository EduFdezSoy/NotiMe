## Base de datos:
nombre = notime  
estructura =  
	auto_logs:  
		id (primary key) = int, auto increment  
		service_id (fk) = char(10)  
		ok = voleano <- estado, 1 su funca 0 si no funca  
		timedate = timestamp  
	services:  
		id (primary key) = int, auto increment  
		order = int <- este numero puede y debe cambiar  
		service = varchar(50)  
		description = varchar(240)  
	incidences:  
		id (primary key) = int, auto increment  
		inc_num = int <- una incidencia puede y debe tener varios comentarios  
		title = varchar(50)  
		description = varchar (240)  
		open = timestamp <- fecha de apertura, puede ser anterior a la fecha actual, se abre sola cuando algun servicio falla  
		close = timestamp <- fecha de cerrado, cuando la incidencia se soluciona, las incidencias automaticas se pueden autocerrar si el servicio vuelve a responder con exito  
		timedate = timestamp <- fecha del comentario, si existe  
  
faltan las tablas de registro y gestoin de usuarios  