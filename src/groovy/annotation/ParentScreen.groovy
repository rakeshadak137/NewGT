package annotation

import java.lang.annotation.ElementType
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.Target


@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface ParentScreen {

    String name();

    String fullName();

    String subUnder();
}


