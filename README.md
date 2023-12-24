# Amazon Clone
## Auth
- The screens folder will have code for things like login screen, signup screen
- Widgets will have reusable widgets
- Services will have have the business logic such as connecting to server, sending API calls etc.

**For errors like `Navigator operation requested with a context that does not include a Navigator`, Use a Builder wrapped around the widget causing the push**

The auth middleware is to check if the user is validated or not, if he is, then the middleware attaches the id.