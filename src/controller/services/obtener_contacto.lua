-- Import the contact model
local Contacto = require("src.model.contact")

-- @description: service to get a contact

function obtener_contacto(nombre_persona, table_runtime)
	-- Search for the contact by name in the runtime table
	for _, contacto in ipairs(table_runtime) do
		if contacto.name == nombre_persona then
			return contacto
		end
	end
	return nil, "Contact not found"
end

-- return the function
return obtener_contacto