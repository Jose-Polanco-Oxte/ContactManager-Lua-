local View = {}

function View:showMenu()
    print("")
    print("=== Gestión de Contactos ===")
    print("1. Agregar un contacto")
    print("2. Consultar un contacto por nombre")
    print("3. Listar contactos por mes de cumpleaños")
    print("4. Listar todos los contactos ordenados alfabéticamente")
    print("5. Actualizar un contacto")
    print("6. Salir")
    io.write("Seleccione una opción: ")
    print("")
end

function View:showContact(contact)
    print("")
    print("=== Información del Contacto ===")
    print("Nombre: " .. contact.name)
    print("Cumpleaños: " .. contact.birthday_date) 
    print("Teléfono: " .. contact.phone)
    print("Correo: " .. contact.email)
    print("===============================")
    print("")
end

function View:showContacts(contacts)
    print("")
    print("=== Lista de Contactos ===")
    for _, contact in ipairs(contacts) do
        print(contact.name .. " - " .. contact.birthday_date .. " - " .. contact.phone .. " - " .. contact.email) 
        print("")
    end
    print("==========================")
    print("")
end

function View:showMessage(message)
    print(message)
end

return View
