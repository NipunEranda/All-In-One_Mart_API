const syncsql = require('sync-sql');
const secret = 'zyph3r141';
const tokenExpireAfter = '24h';
const hostIP = 'localhost';
const hostPORT = '5001';
const emailUser = 'aiomartdev@gmail.com';
const emailPw = 'sqgzdokzhnvianfm';

//Database credentials and connection links
db = {
    host: '3.90.204.186',
    user: 'dev',
    password: '1234',
    database: 'aiomart_cm',
    multipleStatements: true
};

accessList = {
    adminOnly : [1],
    customerOnly: [2],
    supplierOnly: [3],
    adminNCustomer: [1, 2],
    adminNSupplier: [1, 3],
    all : [1, 2, 3]
};

//Exports list
module.exports = {
    secret,
    tokenExpireAfter,
    hostIP,
    db,
    accessList,
    hostPORT,
    emailUser,
    emailPw,
    //Execute Mysql commands
    executeQuery: (sql) => {
        return syncsql.mysql(db, sql);
    }
}