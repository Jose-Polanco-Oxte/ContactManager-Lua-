local Contact = require("src.model.contact")

local IOManager = {}
IOManager.__index = IOManager

-- Función interna que convierte un objeto Contact a una línea CSV formateada.
-- Recibe un contacto y retorna una cadena con el formato CSV: "name","email","phone","birthday_date"\n
local function serializar_contacto(contact)
    return string.format('"%s","%s","%s","%s"\n',
        contact.name or "",
        contact.email or "",
        contact.phone or "",
        contact.birthday_date or ""
    )
end

-- Guarda la lista de contactos en un archivo CSV.
-- parámetro contact_list Tabla con objetos Contact.
-- parámetro filepath Ruta del archivo donde se guardarán los contactos.
-- return true si se guarda correctamente, false y mensaje de error en caso contrario.
function IOManager.persistir_contactos(contact_list, filepath)
    local file, err = io.open(filepath, "w")
    if not file then
        return false, "Error al abrir archivo para guardar: " .. (err or "")
    end

    -- Escribir encabezado CSV
    file:write("name,email,phone,birthday_date\n")

    -- Escribir cada contacto serializado
    for _, contact in ipairs(contact_list) do
        file:write(serializar_contacto(contact))
    end

    file:close()
    return true  -- Indica éxito al guardar
end

-- Verifica si el archivo CSV existe, tiene un encabezado válido y no está vacío.
-- parámetrofilepath Ruta del archivo CSV.
-- return true si el archivo es válido, false y mensaje de error si no.
function IOManager.comprobar_integridad(filepath)
    local file = io.open(filepath, "r")
    if not file then
        return false, "Archivo no encontrado"
    end

    -- Leer la primera línea y validar encabezado
    local encabezado = file:read("*l")
    if not encabezado or encabezado ~= "name,email,phone,birthday_date" then
        file:close()
        return false, "Encabezado inválido"
    end

    -- Leer la siguiente línea para asegurar que hay datos
    local siguiente_linea = file:read("*l")
    file:close()

    if not siguiente_linea then
        return false, "Archivo vacío (sin contactos)"
    end

    return true  -- Archivo válido
end

-- Carga los contactos desde un archivo CSV y retorna una tabla con objetos Contact.
-- parámetro filepath Ruta del archivo CSV.
-- return Tabla con contactos o nil y mensaje de error.
function IOManager.cargar_contactos(filepath)
    local contactos = {}
    local file = io.open(filepath, "r")

    if not file then
        return nil, "No se pudo abrir el archivo para lectura"
    end

    file:read("*l")  -- Saltar el encabezado CSV

    -- Leer línea por línea y crear objetos Contact
    for linea in file:lines() do
        -- Extraer campos con pattern matching para CSV con comillas
        local name, email, phone, birthday = linea:match('"(.-)","(.-)","(.-)","(.-)"')

        if name then
            local contacto, err = Contact:new(name, email, phone, birthday)
            if contacto then
                table.insert(contactos, contacto)
            else
                -- Imprimir error si el contacto no es válido pero continuar la carga
                print("[IOManager] Contacto inválido ignorado: " .. err)
            end
        end
    end

    file:close()
    return contactos
end

--- Serializa un solo contacto en formato CSV (sin salto de línea al final).
-- Útil para mostrar o testear un contacto individual.
-- parámetro contact: Objeto Contact.
-- return Cadena CSV con campos entre comillas.
function IOManager.serializar_contacto(contact)
    return serializar_contacto(contact):gsub("\n", "")  -- elimina salto de línea final
end

return IOManager

