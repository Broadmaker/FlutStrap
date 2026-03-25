// ✅ GOOD: Compose validators for complex validation
String? validateComplexField(String? value) {
if (FSValidators.isEmpty(value)) {
return 'This field is required';
}

if (!FSValidators.isEmail(value)) {
return 'Please enter a valid email';
}

if (value!.length < 8) {
return 'Email must be at least 8 characters';
}

return null;
}
