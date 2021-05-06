<h1 align="center">Welcome to HOMEnVentory 👋</h1>

## What project is it?

> This web application helps homeowners keep track of their inventory of household items for insurance purposes. I created this project in the third semester of college <a href="https://www.sait.ca/programs-and-courses/diplomas/information-technology" target='_blank'>(SAIT)</a>.

## Functionality

- ### Registration:

  Users can register (create) an account consisting of an email address, password, first name, and last name.

  1. When a user registers an account, an email is sent to the provided email address. The email contains a link which the user must click in order to activate their account. After the user has activated their account, a welcome email will be sent to them.
  2. All passwords to be salted and hashed using a strong one-way encryption algorithm.

- ### Authentication:

  Users can login using an email address and password and logout.

- ### Manage User Account:

  Users can edit their account information, but they cannot delete their own account.

- ### Reset password:

  If a user forgets their password, they will have the option to reset their password. If they choose to reset a password, they will receive an email containing a link which will send them to a page to enter a new password.

- ### Account Active/Inactive:

  Users can deactivate their account from the account page. If an account has been deactivated, the user cannot log in. Only a system administrator can reactive their account.

- ### Manage Inventory:

  A home inventory item consists of category, name, and price. Users can view, add, delete and edit their own items.

- ### Manage Users, Roles and Categories:

  A system administrator is able to manage all aspects of the system below. A company administrator, on the other hand, can only manage users of the same company as them.

  1. View all accounts.
  2. Create, edit and delete an account. (Deleting an account will delete all of the associated items for that account.)
  3. Promote and demote a user.
  4. Search all items through the search box. It displays the item name and the owner of the item.
  5. View, add and edit the list of categories. (Cannot delete categories)

## Database ERD (MySQL)

![erd](https://github.com/Jaeyoung-Kim-Dev/HOMEnVentory/blob/master/screenshots/database_erd.jpg?raw=true)

## Languages

<p align="left"> <a href="https://www.java.com" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/java/java-original.svg" alt="java" width="40" height="40"/> </a><a href="https://www.mysql.com/" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/mysql/mysql-original-wordmark.svg" alt="mysql" width="40" height="40"/> </a>  <a href="https://getbootstrap.com" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/bootstrap/bootstrap-plain-wordmark.svg" alt="bootstrap" width="40" height="40"/> </a><a href="https://git-scm.com/" target="_blank"> <img src="https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg" alt="git" width="40" height="40"/> </a> </p>

- Other technoloies: JSP, Servlet, JPA
- IDE: NetBeans
- Server: Apache Tomcat 8.0.27.0

## Screen Shots

![erd](https://github.com/Jaeyoung-Kim-Dev/HOMEnVentory/blob/master/screenshots/screenshot1.jpg?raw=true)
![erd](https://github.com/Jaeyoung-Kim-Dev/HOMEnVentory/blob/master/screenshots/screenshot2.jpg?raw=true)
![erd](https://github.com/Jaeyoung-Kim-Dev/HOMEnVentory/blob/master/screenshots/screenshot3.jpg?raw=true)
![erd](https://github.com/Jaeyoung-Kim-Dev/HOMEnVentory/blob/master/screenshots/screenshot4.jpg?raw=true)
![erd](https://github.com/Jaeyoung-Kim-Dev/HOMEnVentory/blob/master/screenshots/screenshot5.jpg?raw=true)
![erd](https://github.com/Jaeyoung-Kim-Dev/HOMEnVentory/blob/master/screenshots/screenshot6.jpg?raw=true)

## Author

👤 **Jaeyoung Kim**

- Website: https://www.jaeyoungkim.ca/
- Github: [@jaeyoung-kim-dev](https://github.com/jaeyoung-kim-dev)
- LinkedIn: [@jaeyoung-kim-dev](https://www.linkedin.com/in/jaeyoung-kim-dev/)
