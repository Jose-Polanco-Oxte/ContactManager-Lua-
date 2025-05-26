-- Import the contact model
local Contacto = require("src.model.contact")

-- @description: service to get a sorted list of contacts

function obtener_contactos_ordenados(tabla_runtime)
	if not tabla_runtime or #tabla_runtime == 0 then
		return nil, "No hay contactos disponibles."
	end
	-- Sort the contacts by name
	table.sort(tabla_runtime, function(a, b)
		return a.name < b.name
	end)
	-- Return the sorted list of contacts
	return tabla_runtime
end

-- return the function
return obtener_contactos_ordenados