-- import validator
local validator = require("src.model.validation")

Contact = {}
Contact.__index = Contact

function Contact:new(name, email, phone, birthday_date)
	-- Validate the input data
	-- Validate the name
	local valid_name, err = validator:valid_name(name)
	if not valid_name then
		return nil, err
	end
	-- Validate the email
	local valid_email, err = validator:valid_email(email)
	if not valid_email then
		return nil, err
	end
	-- Validate the phone
	local valid_phone, err = validator:valid_phone(phone)
	if not valid_phone then
		return nil, err
	end
	-- Validate the birthday date
	local valid_birthday_date, err = validator:valid_birthday_date(birthday_date)
	if not valid_birthday_date then
		return nil, err
	end
	-- Create a new contact instance
	local self = setmetatable({}, Contact)
	self.name = name or "Unknown"
	self.birthday_date= birthday_date or "No data"
	self.phone = phone or "No data"
	self.email = email or "No data"
	return self
end

function Contact:change_name(new_name)
	-- Validate the new name
	local valid_name, err = validator:valid_name(new_name)
	if not valid_name then
		return nil, err
	end
	-- Change the name of the contact
	self.name = new_name
end

function Contact:change_email(new_email)
	-- Validate the new email
	local valid_email, err = validator:valid_email(new_email)
	if not valid_email then
		return nil, err
	end
	-- Change the email of the contact
	self.email = new_email
end

function Contact:change_phone(new_phone)
	-- Validate the new phone
	local valid_phone, err = validator:valid_phone(new_phone)
	if not valid_phone then
		return nil, err
	end
	-- Change the phone of the contact
	self.phone = new_phone
end

function Contact:change_birthday_date(new_birthday_date)
	-- Validate the new birthday date
	local valid_birthday_date, err = validator:valid_birthday_date(new_birthday_date)
	if not valid_birthday_date then
		return nil, err
	end
	-- Change the birthday date of the contact
	self.birthday_date = new_birthday_date
end

return Contact
