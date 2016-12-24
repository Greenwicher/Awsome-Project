from django import forms
# import sys
# reload(sys)                       
# sys.setdefaultencoding('utf-8')

class AuthorForm(forms.Form):
	first_name = forms.CharField()
	last_name = forms.CharField()
	email = forms.EmailField(required=False)