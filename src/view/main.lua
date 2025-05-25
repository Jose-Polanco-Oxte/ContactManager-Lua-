-- Aquí se tiene que poner el directorio de la carpeta donde se encuentra el archivo main.lua
-- a mi me dio error pero chequenlo a ver si ustedes les funciona sin eso, pero cambienlo
package.path = package.path .. ";/Users/javierortiz/Documents/Repositorios/Programing-Exercises/Lua/PRUEBA PROYECTO/?.lua"

--Cambiar las rutas
local View = require("view")
local ContactController = require("Controller.ContactController")
local FileManager = require("IO.FileManager")

local function main()
    local view = View
    local controller = ContactController:new()
    local fileManager = FileManager
    local filename = "contacts.txt"

    -- Cargar contactos desde el archivo
    controller.contacts = fileManager:loadFromFile(filename)

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
            local success, message = controller:addContact(name, birthday, phone, email)
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
            local contact, message = controller:getContactByName(name)
            if contact then
                view:showContact(contact)
            else
                view:showMessage(message)
            end
            print("") 
        elseif option == 3 then
            print("")
            io.write("Ingrese el mes (mm): ")
            local month = io.read()
            local contacts = controller:getContactsByMonth(month)
            view:showContacts(contacts)
            print("") 
        elseif option == 4 then
            print("")
            local contacts = controller:getAllContacts()
            view:showContacts(contacts)
            print("") 
        elseif option == 5 then
            print("")
            io.write("Ingrese el nombre del contacto a actualizar: ")
            local name = io.read()
            local contact, message = controller:getContactByName(name)
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
                local success, update_message = controller:updateContact(
                    name,
                    new_name ~= "" and new_name or nil,
                    new_email ~= "" and new_email or nil,
                    new_phone ~= "" and new_phone or nil,
                    new_birthday_date ~= "" and new_birthday_date or nil
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
            fileManager:saveToFile(filename, controller.contacts)
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
