-- Cambiar las rutas
local View = require("src.view.view")
local ContactController = require("src.controller.contact_controller")

local function main()
    local view = View
    local controller = ContactController:new("src/files")

    while true do
        view:showMenu()
        local option = io.read("*n")
		io.read() -- Clear the newline character from the input buffer
        if option == 1 then
            while true do
                print("")
                io.write("Nombre: ")
                local name = io.read()
                io.write("Cumpleaños (dd/mm): ")
                local birthday = io.read()
                io.write("Teléfono: ")
                local phone = io.read()
                io.write("Correo: ")
                local email = io.read()
                local success, err = controller:crear_contacto(name, email, phone, birthday)
                if success then
                    view:showMessage("Contacto agregado exitosamente.")
                    break
                else
                    view:showMessage("Error: " .. err)
                end
            end
            print("")
        elseif option == 2 then
            while true do
                print("")
                io.write("Ingrese el nombre del contacto: ")
                local name = io.read()
                local contact, err = controller:obtener_contacto(name)
                if contact then
                    view:showContact(contact)
                    break
                else
                    view:showMessage(err)
                end
            end
            print("")
        elseif option == 3 then
            while true do
                print("")
                io.write("Ingrese el mes (mm): ")
                local month = tonumber(io.read())
                local contacts, err = controller:obtener_por_birthday(month)
                if contacts then
                    view:showContacts(contacts)
                    break
                else
                    view:showMessage(err)
                end
            end
            print("")
        elseif option == 4 then
            while true do
                print("")
                local contacts, err = controller:obtener_contactos_ordenados()
                if contacts then
                    view:showContacts(contacts)
                    break
                else
                    view:showMessage(err)
                end
            end
            print("")
        elseif option == 5 then
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
