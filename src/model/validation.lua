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
		return nil, "Invalid name: " .. tostring(name)
	end
	if (#name < 3) or (#name > 50) then
		return nil, "Name must be between 3 and 50 characters"
	end
	if not name:match("^[a-zA-Z ]+$") then
		return nil, "Name can only contain letters and spaces"
	end
	return true
end

function Validator:valid_email(email)
	if type(email) ~= "string" or email == "" then
		return nil, "Invalid email: " .. tostring(email)
	end
	if not isEmail(email) then
		return nil, "Invalid email format: " .. email
	end
	if (#email < 5) or (#email > 50) then
		return nil, "Email must be between 5 and 50 characters"
	end
	return true
end

function Validator:valid_phone(phone)
	if type(phone) ~= "string" or phone == "" then
		return nil, "Invalid phone: " .. tostring(phone)
	end
	if not phone:match("^[0-9]+$") then
		return nil, "Phone can only contain numbers"
	end
	if (#phone < 7) or (#phone > 15) then
		return nil, "Phone must be between 7 and 15 digits"
	end
	return true
end

function Validator:valid_birthday_date(str)
	-- Verificar el patrón básico: 2 dígitos / 2 dígitos
    if not string.match(str, "^%d%d/%d%d$") then
		return nil, "Invalid birthday date format: " .. birthday_date
    end
    
    -- Extraer día y mes
    local dia, mes = string.match(str, "(%d%d)/(%d%d)")
    dia = tonumber(dia)
    mes = tonumber(mes)
    
    -- Validar rango del mes (1-12)
    if mes < 1 or mes > 12 then
		return nil, "Invalid month: " .. mes
    end
    
    -- Validar rango del día (1-31)
    if dia < 1 or dia > 31 then
		return nil, "Invalid day: " .. dia
    end
    
    -- Validar días según el mes
    local diasPorMes = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    if dia > diasPorMes[mes] then
		return nil, "Invalid day for month " .. mes .. ": " .. dia
    end
	return true
end

return Validator