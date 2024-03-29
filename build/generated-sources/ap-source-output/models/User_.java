package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Company;
import models.Item;
import models.Role;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-12-13T22:40:11")
@StaticMetamodel(User.class)
public class User_ { 

    public static volatile SingularAttribute<User, String> firstName;
    public static volatile SingularAttribute<User, String> lastName;
    public static volatile SingularAttribute<User, String> password;
    public static volatile SingularAttribute<User, String> salt;
    public static volatile SingularAttribute<User, Role> role;
    public static volatile SingularAttribute<User, Boolean> active;
    public static volatile ListAttribute<User, Item> itemList;
    public static volatile SingularAttribute<User, Company> company;
    public static volatile SingularAttribute<User, String> emailVerifyUuid;
    public static volatile SingularAttribute<User, String> email;
    public static volatile SingularAttribute<User, String> resetPasswordUuid;

}