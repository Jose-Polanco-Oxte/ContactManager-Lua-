-- Import the contact model
local Contacto = require("src.model.contact")

-- @description: service to get a contact

function obtener_por_mes_cumple(month_number, table_runtime)
	if not table_runtime or #table_runtime == 0 then
		return nil, "No hay contactos disponibles."
	end
	if not month_number or month_number < 1 or month_number > 12 then
		return nil, "Numero de mes inválido. Debe ser un número entre 1 y 12."
	end
	local contacts_with_birthday = {}
	for _, contacto in ipairs(table_runtime) do
		-- extract the month (dd/mm) "mm"
		local birthday_month = contacto.birthday_date:match("^%d%d/(%d%d)$")
		local month_num = tonumber(birthday_month)
		if month_num == month_number then
			table.insert(contacts_with_birthday, contacto)
		end
	end
	-- Check if any contacts were found
	if #contacts_with_birthday == 0 then
		return nil, "No hay contactos con cumpleaños en el mes especificado."
	end
	-- Return the list of contacts with the specified birthday date
	return contacts_with_birthday
end

-- return the function
return obtener_por_mes_cumple