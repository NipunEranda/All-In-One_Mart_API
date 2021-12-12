USE aiomart_um;

/*Start of User Management*/
    /*Update User Details*/
        delimiter / /

        CREATE PROCEDURE user_updateUserDetails (
            IN fname VARCHAR(255)
            ,IN lname VARCHAR(255)
            ,IN dob DATE
            ,IN phoneNo VARCHAR(10)
            ,IN gender VARCHAR(1)
            ,IN address VARCHAR(255)
            ,IN id BIGINT (200)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            UPDATE usr_User
            SET usr_User.fname = fname
                ,usr_User.lname = lname
                ,usr_User.dob = dob
                ,usr_User.phoneNo = phoneNo
                ,usr_User.gender = gender
                ,usr_User.address = address
            WHERE usr_User.id = id;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Delete User*/
        delimiter / /

        CREATE PROCEDURE user_deleteUser (
            IN id BIGINT (200)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            UPDATE usr_User
            SET usr_User.isDelete = 1
                ,usr_User.isActive = 0
            WHERE usr_User.id = id;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Change Password*/
        delimiter / /

        CREATE PROCEDURE user_changePassword (
            IN password VARCHAR(255)
            ,IN email VARCHAR(255)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            UPDATE usr_Login
            SET usr_Login.password = password
            WHERE usr_Login.email = email;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Forgot Password*/
        delimiter / /

        CREATE PROCEDURE user_forgotPassword (
            IN password VARCHAR(255)
            ,IN userId BIGINT (200)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            UPDATE usr_Login
            SET usr_Login.password = password
            WHERE usr_Login.userId = userId;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Email Confirmation*/
        delimiter / /

        CREATE PROCEDURE user_confirmEmailConfirmation (
            IN email VARCHAR(255)
            ,IN confirmationCode VARCHAR(255)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            UPDATE usr_Login
            SET usr_Login.isConfirmed = 1
            WHERE usr_Login.email = email
                AND usr_Login.confirmationCode = confirmationCode;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Request Email Confirmation Code*/
        delimiter / /

        CREATE PROCEDURE user_requestEmailConfirmationCode (
            IN confirmationCode VARCHAR(255)
            ,IN email VARCHAR(255)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            UPDATE usr_Login
            SET usr_Login.confirmationCode = confirmationCode
            WHERE usr_Login.email = email;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

/*End of User Management*/

/*Start of Customer Management*/
    /* Customer Registration */
        delimiter / /

        CREATE PROCEDURE customer_Registration (
            /*usr_User*/
            IN fname VARCHAR(255)
            ,IN lname VARCHAR(255)
            ,IN dob DATE
            ,IN phoneNo VARCHAR(15)
            ,IN gender VARCHAR(1)
            ,IN address VARCHAR(255)
            ,
            /*usr_Login*/
            IN email VARCHAR(255)
            ,IN password VARCHAR(255)
            ,IN confirmationCode VARCHAR(8)
            ,
            /*usr_dtl_Client*/
            OUT STATUS INT
            )

        BEGIN
            DECLARE userID BIGINT (200);
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR 1062

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT CONCAT ('Duplicate key occurred') AS message;
            END;

            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            INSERT INTO usr_User (
                fname
                ,lname
                ,dob
                ,phoneNo
                ,gender
                ,address
                ,isActive
                ,isDelete
                )
            VALUES (
                fname
                ,lname
                ,dob
                ,phoneNo
                ,gender
                ,address
                ,1
                ,0
                );

            SELECT MAX(id)
            INTO userID
            FROM usr_User;

            INSERT INTO usr_Login
            VALUES (
                userID
                ,email
                ,password
                ,2
                ,0
                ,confirmationCode
                );

            INSERT INTO usr_dtl_Customer
            VALUES (userID);

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Update Customer details*/
        delimiter / /

        CREATE PROCEDURE customer_updateCustomerDetails (
            IN userId BIGINT (200)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            /*UPDATE usr_dtl_Client
        WHERE usr_dtl_Client.id = userId;*/
            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Delete Customer*/
        delimiter / /

        CREATE PROCEDURE customer_deleteCustomer (
            IN id BIGINT (200)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            DELETE
            FROM usr_dtl_Customer
            WHERE usr_dtl_Customer.id = id;

            DELETE
            FROM usr_Login
            WHERE usr_Login.userId = id;

            DELETE
            FROM usr_User
            WHERE usr_User.id = id;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

/*End of Customer Management*/

/*Start of Supplier Management*/
    /*Supplier Registration*/
        delimiter / /

        CREATE PROCEDURE supplier_Registration (
            /*usr_User*/
            IN fname VARCHAR(255)
            ,IN lname VARCHAR(255)
            ,IN dob DATE
            ,IN phoneNo VARCHAR(15)
            ,IN gender VARCHAR(1)
            ,IN address VARCHAR(255)
            ,
            /*usr_Login*/
            IN email VARCHAR(255)
            ,IN password VARCHAR(255)
            ,IN confirmationCode VARCHAR(8)
            ,
            /*usr_dtl_Supplier*/
            IN joinedDate VARCHAR(255)
            ,OUT STATUS INT
            )

        BEGIN
            DECLARE userID BIGINT (200);
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR 1062

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT CONCAT ('Duplicate key occurred') AS message;
            END;

            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            INSERT INTO usr_User (
                fname
                ,lname
                ,dob
                ,phoneNo
                ,gender
                ,address
                ,isActive
                ,isDelete
                )
            VALUES (
                fname
                ,lname
                ,dob
                ,phoneNo
                ,gender
                ,address
                ,1
                ,0
                );

            SELECT MAX(id)
            INTO userID
            FROM usr_User;

            INSERT INTO usr_Login
            VALUES (
                userID
                ,email
                ,password
                ,3
                ,0
                ,confirmationCode
                );

            INSERT INTO usr_dtl_Supplier
            VALUES (
                userID
                ,joinedDate
                ,1
                ,0
                );

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Update Supplier details*/
        delimiter / /

        CREATE PROCEDURE supplier_updateSupplierDetails (
            IN userId BIGINT (200)
            ,IN joinedDate DATE
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            UPDATE usr_dtl_Supplier
            SET usr_dtl_Supplier.joinedDate = joinedDate
            WHERE usr_dtl_Supplier.id = userId;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /

    /*Delete Supplier*/
        delimiter / /

        CREATE PROCEDURE supplier_deleteSupplier (
            IN id BIGINT (200)
            ,OUT STATUS INT
            )

        BEGIN
            /*Start Error Handling*/
            DECLARE EXIT HANDLER
            FOR SQLEXCEPTION

            BEGIN
                ROLLBACK;

                SET STATUS = 0;

                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

            /*End Error Handling*/
            START TRANSACTION;

            DELETE
            FROM usr_dtl_Supplier
            WHERE usr_dtl_Supplier.id = id;

            DELETE
            FROM usr_Login
            WHERE usr_Login.userId = id;

            DELETE
            FROM usr_User
            WHERE usr_User.id = id;

            SET STATUS = 1;

            COMMIT;
        END / /

        delimiter / /
/*End of Supplier Management*/