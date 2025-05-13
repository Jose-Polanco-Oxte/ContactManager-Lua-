-- import the contact model
local Contacto = require("src.model.contact")

-- @description: service to create a contact

function crear_contacto(name, email, phone, birthday_date, tabla_runtime)
	-- Create a new contact instance
	local contacto, err = Contacto:new(name, email, phone, birthday_date)
	-- Check if there was an error creating the contact
	if not contacto then
		-- If there was an error, return nil and the error message
		return nil, err
	end
	-- append the new contact to the runtime table
	table.insert(tabla_runtime, contacto)
	-- return the new contact
	return contacto
end

-- return the function
return crear_contacto