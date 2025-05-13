Contact = {}
Contact.__index = Contact

function Contact:new(name, email, phone, birthday_date)
	local self = setmetatable({}, Contact)
	self.name = name or "Unknown"
	self.birthday_date= birthday_date or "No data"
	self.phone = phone or "No data"
	self.email = email or "No data"
	return self
end

function Contact:change_name(new_name)
	self.name = new_name
end

function Contact:change_email(new_email)
	self.email = new_email
end

function Contact:change_phone(new_phone)
	self.phone = new_phone
end

function Contact:change_birthday_date(new_birthday_date)
	self.birthday_date = new_birthday_date
end

return Contact
