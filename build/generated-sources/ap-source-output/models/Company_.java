package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.User;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-12-13T22:10:16")
@StaticMetamodel(Company.class)
public class Company_ { 

    public static volatile SingularAttribute<Company, Integer> companyId;
    public static volatile ListAttribute<Company, User> userList;
    public static volatile SingularAttribute<Company, String> companyName;

}