-- import contact controller
local ContactController = require("src.controller.contact_controller")


-- @description: test for contact controller

local controller = ContactController:new()
-- test data
local contact_1, err = controller:crear_contacto("John Doe", "pene@gmail.com", "99423523", "04/02")

if not contact_1 then
	print(err)
	return
end

print("Contacto 1: " .. contact_1.name)


-- test obtener contacto
local get, err = controller:obtener_contacto("John Doe")
if not get then
	print(err)
	return
end
print("Contacto encontrado: " .. get.name)

-- test save_contacts
controller:guardar_contactos()