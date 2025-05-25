-- Ajustar el directorio de la carpeta donde se encuentra el archivo main.lua
package.path = package.path .. ";/Users/javierortiz/Documents/Repositorios/ContactManager-Lua-/src/?.lua"

-- Cambiar las rutas
local View = require("view.view")
local ContactController = require("controller.contact_controller")
local IOManager = require("controller.persistence.io_manager")

local function main()
    local view = View
    local controller = ContactController:new("src")
    local filename = "src/contactos.csv"

    -- Cargar contactos desde el archivo
    local success, message = IOManager.comprobar_integridad(filename)
    if not success then
        view:showMessage("Error al cargar contactos: " .. message)
        return
    end

    while true do
        view:showMenu()
        local option = io.read("*n")
        io.read()

        if option == 1 then
            print("")
            io.write("Nombre: ")
            local name = io.read()
            io.write("Cumpleaños (dd/mm): ")
            local birthday = io.read()
            io.write("Teléfono: ")
            local phone = io.read()
            io.write("Correo: ")
            local email = io.read()
            local success, message = controller:crear_contacto(name, email, phone, birthday)
            if success then
                view:showMessage("Contacto agregado exitosamente.")
            else
                view:showMessage("Error: " .. message)
            end
            print("")
        elseif option == 2 then
            print("")
            io.write("Ingrese el nombre del contacto: ")
            local name = io.read()
            local contact, message = controller:obtener_contacto(name)
            if contact then
                view:showContact(contact)
            else
                view:showMessage(message)
            end
            print("")
        elseif option == 3 then
            print("")
            io.write("Ingrese el mes (mm): ")
            local month = tonumber(io.read())
            local contacts, message = controller:obtener_por_birthday(month)
            if contacts then
                view:showContacts(contacts)
            else
                view:showMessage(message)
            end
            print("")
        elseif option == 4 then
            print("")
            local contacts, message = controller:obtener_contactos_ordenados()
            if contacts then
                view:showContacts(contacts)
            else
                view:showMessage(message)
            end
            print("")
        elseif option == 5 then
            print("")
            io.write("Ingrese el nombre del contacto a actualizar: ")
            local name = io.read()
            local contact, message = controller:obtener_contacto(name)
            if not contact then
                view:showMessage("Error: " .. message)
            else
                io.write("Nuevo nombre (dejar vacío para no cambiar): ")
                local new_name = io.read()
                io.write("Nuevo correo (dejar vacío para no cambiar): ")
                local new_email = io.read()
                io.write("Nuevo teléfono (dejar vacío para no cambiar): ")
                local new_phone = io.read()
                io.write("Nueva fecha de cumpleaños (dd/mm, dejar vacío para no cambiar): ")
                local new_birthday_date = io.read()
                local success, update_message = controller:crear_contacto(
                    new_name ~= "" and new_name or contact.name,
                    new_email ~= "" and new_email or contact.email,
                    new_phone ~= "" and new_phone or contact.phone,
                    new_birthday_date ~= "" and new_birthday_date or contact.birthday_date
                )
                if success then
                    view:showMessage("Contacto actualizado exitosamente.")
                else
                    view:showMessage("Error: " .. update_message)
                end
            end
            print("")
        elseif option == 6 then
            print("")
            -- Guardar contactos en el archivo antes de salir
            controller.guardar_contactos()
            view:showMessage("¡Hasta luego!")
            print("")
            break
        else
            print("")
            view:showMessage("Opción no válida. Intente de nuevo.")
            print("")
        end
    end
end

main()
