# Why This Fork Exists

This project was forked from https://github.com/obsidiandynamics/kafdrop
to address specific requirements that we had in our environment.
The primary requirements were:

* Provide a proper login screen and associated credentials.
* Support access via a secure reverse proxy

Given the scope of some of the required changes, I have elected not
to submit pull requests to the original project for all of the changes
as it is unlikely that they all would have been accepted.

## Modifications to the Original Kafdrop

### Added a login screen with associated credentials. 
* The default credentials are username: admin, password: admin. These
are configured in the application.yml file.
* The default credentials can be overridden by setting the properties 
on the command line.
* These changes are generally useful and add needed capability to
the original. A pull request has been submitted to have them included.

### Reworked kafdrop.sh 
* Added login credential support to the script that configures the runtime
environment when Kafdrop is run in Docker.
* The script as it existed failed "shellcheck" syntax check utility 
pretty badly. Made some changes to clean it up.
* This file was not submitted as a pull request as these
changes came late in the process and after the pull request for
the login page was submitted, but it easily could be.

### Added a light switch to toggle between dark and light mode
* Replaced GitHub logo/link on title line with the light switch. 
Including both the light switch and the GitHub logo/link did not
work well aesthetically IMO.
* This was added more for grins and giggles and not a hard requirement.
I did take the opportunity to rework some of the color scheme in the
default theme in the process, but it remains largely based on the
original bootswatch "darkly" theme. When the light switch is "on", 
there is small resemblance of the bootswatch "flatly" theme, although
it is not a complete remapping.
* These changes, while fun, do not substantially improve the original
and were not submitted as a pull request.

### Added support for favicon.ico
* There was not a favicon included in the original. This resulted in
404 "not found" warnings in the browser. This is not a fatal error,
but not optimal IMO.
* I converted the Kafdrop logo to an icon and made the changes necessary
to support display of it as a favicon.ico.
* While this is generally useful, they occurred later in the development
process, making submission of a pull request challenging. The changes 
were fairly trivial and would be easy to recreate elsewhere if desired.

### Changes to support access via a reverse proxy
There were a number of changes needed to support access via a
reverse proxy in our environment due to Content Security Policy settings 
on our side. These issues did not exist when running through a vanilla
nginx reverse proxy with no security restrictions.
* The primary issues were with font-awesome. I wound up having to make
some edits in the font-awesome.css file in order to get things working.
In the process, I had to upgrade from font-awesome version 4.5 to
version 4.7 as 4.5 seemed to have been deprecated / replaced. I opted 
not to upgrade to font-awesome version 5.x as the changes to the 
style sheet would have forced more changes in the template files as well.
* I had to make a change to the application.yml file to 
set the *forward-headers-strategy* to *NATIVE*.
* These changes were not submitted as a pull request as they came
after the addition of the light switch, making submission somewhat
difficult.


