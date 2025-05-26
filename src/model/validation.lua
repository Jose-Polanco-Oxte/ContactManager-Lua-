Validator = {}
Validator.__index = Validator

local function isEmail(str)
	local _,nAt = str:gsub('@','@') -- Counts the number of '@' symbol
	if nAt > 1 or nAt == 0 or str:len() > 254 or str:find('%s') then return false end
	local localPart = str:match("^(.-)@") -- Returns the substring before '@' symbol
	local domainPart = str:match("@(.+)$") -- Returns the substring after '@' symbol
	if not localPart or not domainPart then return false end

	if not localPart:match("[%w!#%$%%&'%*%+%-/=%?^_`{|}~]+") or (localPart:len() > 64) then return false end
	if localPart:match('^%.+') or localPart:match('%.+$') or localPart:find('%.%.+') then return false end

	if not domainPart:match('[%w%-_]+%.%a%a+$') or domainPart:len() > 253 then return false end
	local fDomain = domainPart:match("^(.*)%.") -- Returns the substring in the domain-part before the last (dot) character
	if fDomain:match('^[_%-%.]+') or fDomain:match('[_%-%.]+$') or fDomain:find('%.%.+') then return false end

	return true
end


function Validator:new()
	local self = setmetatable({}, Validator)
	return self
end

function Validator:valid_name(name)
	if type(name) ~= "string" or name == "" then
		return nil, "Formato de nombre invalido: " .. tostring(name)
	end
	if (#name < 3) or (#name > 50) then
		return nil, "El nombre debe tener entre 3 y 50 caracteres"
	end
	if not name:match("^[a-zA-Z ]+$") then
		return nil, "El nombre solo puede contener letras y espacios"
	end
	return true
end

function Validator:valid_email(email)
	if type(email) ~= "string" or email == "" then
		return nil, "Email invalido: " .. tostring(email)
	end
	if not isEmail(email) then
		return nil, "Formato de email invalido: " .. email
	end
	if (#email < 5) or (#email > 50) then
		return nil, "El email debe tener entre 5 y 50 caracteres"
	end
	return true
end

function Validator:valid_phone(phone)
	if type(phone) ~= "string" or phone == "" then
		return nil, "Número de celular invalido: " .. tostring(phone)
	end
	if not phone:match("^[0-9]+$") then
		return nil, "El número de celular solo puede contener dígitos"
	end
	if (#phone < 7) or (#phone > 15) then
		return nil, "El número de celular debe tener entre 7 y 15 dígitos"
	end
	return true
end

function Validator:valid_birthday_date(str)
	-- Verificar el patrón básico: 2 dígitos / 2 dígitos
	if not string.match(str, "^%d%d/%d%d$") then
		return nil, "Cumpleaños invalido: " .. tostring(str)
	end
	-- Extraer día y mes
	local dia, mes = string.match(str, "(%d%d)/(%d%d)")
	dia = tonumber(dia)
	mes = tonumber(mes)
	-- Validar rango del mes (1-12)
	if mes < 1 or mes > 12 then
		return nil, "Mes invalido: " .. tostring(mes)
	end
	-- Validar rango del día (1-31)
	if dia < 1 or dia > 31 then
		return nil, "Dia invalido: " .. tostring(dia)
	end
	-- Validar días según el mes
	local diasPorMes = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
	if dia > diasPorMes[mes] then
		return nil, "Dia invalido para este mes" .. tostring(mes) .. ": " .. tostring(dia)
	end
	return true
end

return Validator