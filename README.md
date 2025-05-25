# ContactManager-Lua-

Project for a university course which proposes the creation of a system capable of handling contacts, but with the characteristic of being implemented in Lua.

Proyecto: Agenda de Contactos
Responsable de esta parte: Daniela Villarino Budip
Módulo: IO Manager + Modelo Contacto

📦 Archivos incluidos
src/
└── model/
├── contact.lua ← Clase Contacto + validación
├── validation.lua ← Validación de campos
└── io_manager.lua ← Cargar/guardar contactos en archivo

📌 ¿Qué hace cada módulo?

contact.lua: Define cómo es un contacto, valida datos al crearlo/modificar
validation.lua: Funciones internas para validar email, teléfono, etc.
io_manager.lua: Guarda y carga contactos desde un archivo CSV (contactos.csv)

🧪 ¿Cómo usar mis módulos?

1. Importar:

local Contact = require("src.model.contact")
local IOManager = require("src.model.io_manager")

2. Crear un contacto nuevo:

local nuevo, err = Contact:new("Ana", "ana@mail.com", "1234567890", "12/05")
if not nuevo then
print("Error:", err)
else
-- úsalo como objeto
print(nuevo.name)
end

3. Cargar contactos desde el archivo:

local contactos = IOManager.cargar_contactos("contactos.csv")

4. Guardar lista de contactos:

IOManager.persistir_contactos(contactos, "contactos.csv")

5. Comprobar si el archivo es válido:

local ok, err = IOManager.comprobar_integridad("contactos.csv")
if not ok then
print("Archivo inválido:", err)
end

💡 Detalles técnicos

> El archivo de almacenamiento se llama contactos.csv

Formato CSV esperado:

name,email,phone,birthday_date
"Ana Torres","ana@mail.com","1234567890","12/05"

✅ Lo que ya está cubierto

-   Validación automática de campos (nombre, correo, teléfono, cumpleaños)

-   Persistencia de contactos en archivo

-   Carga de contactos al iniciar

-   Detección de archivo dañado o vacío

-   Serialización para integrarse fácilmente con GUI

👥 Pensado para integrarse con:

Un Controlador (controller.lua) que use Contact e IOManager

Una Interfaz Gráfica (view) que interactúe con el Controller
