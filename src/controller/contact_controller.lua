-- import services
local crear_contacto = require("src.controller.services.crear_contacto")
local obtener_contacto = require("src.controller.services.obtener_contacto")
local obtener_contactos_ordenados = require("src.controller.services.obtener_contactos_ordenados")
local obtener_por_birthday = require("src.controller.services.obtener_por_birthday")
local io_controller = require("src.controller.persistence.io_manager")

Controller = {}
Controller.__index = Controller

-- initialize the controller
-- @description: This function initializes the controller with a file (preferably in the path of the folder where it is executed)
function Controller:new(filepath)
	local self = setmetatable({}, Controller)
	local contacts, err = io_controller.cargar_contactos(filepath .. "/contactos.csv")
	if not contacts then
		error("Error al cargar contactos: " .. (err or "Unknown error"))
	end
	self.tabla_runtime = contacts
	-- Métodos que requieren acceso a io usan una closure
	self.guardar_contactos = function()
		io_controller.persistir_contactos(self.tabla_runtime, filepath .. "/contactos.csv")
	end

	return self
end

-- @description: service to create a contact
function Controller:crear_contacto(name, email, phone, birthday_date)
	if self.tabla_runtime == nil then
		-- If the runtime table is nil, return nil and an error message
		return nil, "La tabla de contactos no ha sido inicializada."
	end
	-- Check if the contact is already in the list
	for _, contacto in ipairs(self.tabla_runtime) do
		if contacto.name == name then
			-- If the contact already exists, return nil and an error message
			return nil, "Esta persona ya está en la lista de contactos."
		end
		if contacto.email == email then
			-- If the contact already exists, return nil and an error message
			return nil, "Este correo electrónico ya está en uso."
		end
		if contacto.phone == phone then
			-- If the contact already exists, return nil and an error message
			return nil, "Este número de celular ya está en uso."
		end
	end
	-- Create a new contact using the service
	local contacto, err = crear_contacto(name, email, phone, birthday_date, self.tabla_runtime)
	-- Check if there was an error creating the contact
	if not contacto then
		-- If there was an error, return nil and the error message
		return nil, err
	end
	-- Return the new contact
	return contacto
end

-- @description: service to get a contact
function Controller:obtener_contacto(nombre_persona)
	-- Get the contact using the service
	local contacto, err = obtener_contacto(nombre_persona, self.tabla_runtime)
	-- Check if the contact was found
	if not contacto then
		-- If the contact was not found, return nil and the error message
		return nil, err
	end
	-- Return the contact
	return contacto
end

-- @description: service to get all sorted contacts
function Controller:obtener_contactos_ordenados()
	-- Get all sorted contacts using the service
	local contactos_ordenados, err = obtener_contactos_ordenados(self.tabla_runtime)
	-- Check if there was an error getting the sorted contacts
	if not contactos_ordenados then
		-- If there was an error, return nil and the error message
		return nil, err
	end
	-- Return the sorted contacts
	return contactos_ordenados
end

-- @description: service to get contacts by birthday date
function Controller:obtener_por_birthday(birthday_date)
	-- Get contacts by birthday date using the service
	local contacts_with_birthday, err = obtener_por_birthday(birthday_date, self.tabla_runtime)
	-- Check if there was an error getting the contacts
	if not contacts_with_birthday then
		-- If there was an error, return nil and the error message
		return nil, err
	end
	-- Return the contacts with the specified birthday date
	return contacts_with_birthday
end

-- return the controller
return Controller
--[[ 
	@description: This controller manages the contact list, allowing for the creation, retrieval, and sorting of contacts.
	It uses a mock IO controller to load and save contacts.
]]