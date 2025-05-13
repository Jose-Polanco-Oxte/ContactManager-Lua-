-- import services
local crear_contacto = require("src.controller.services.crear_contacto")
local obtener_contacto = require("src.controller.services.obtener_contacto")
local obtener_contactos_ordenados = require("src.controller.services.obtener_contactos_ordenados")
local obtener_por_birthday = require("src.controller.services.obtener_por_birthday")

-- import the io controller(mock)
local io_controller = function ()
	-- Mock IO controller
	local io_mock = {}

	function io_mock.load_contacts()
		local all_contacts = {}
		return all_contacts
	end

	function io_mock.save_contacts(all_contacts)
		print("mocked output")
	end

	return io_mock
end

Controller = {}
Controller.__index = Controller

-- initialize the controller
function Controller:new()
	local io = io_controller() -- completamente privado
	local self = setmetatable({}, Controller)
	self.tabla_runtime = io.load_contacts()

	-- Métodos que requieren acceso a io usan una closure
	self.guardar_contactos = function()
		io.save_contacts(self.tabla_runtime)
	end

	return self
end

-- @description: service to create a contact
function Controller:crear_contacto(name, email, phone, birthday_date)
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