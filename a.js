
var mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit: 100,
    host: process.env.DB_HOSTNAME,
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
});



function doStuff(query, callBack) {

    try {

        pool.getConnection(function (err, connection) {

            connection.query(query, function (err, rows, fields) {

                if (err) {

                    connection.release();
                    throw err;

                }

                callBack(rows, fields);

            });

        });

    } catch (err) {

        // do somethintg about 
        // bad queries here

    }

}


//
//
//

doStuff('SELECT blah FROM foo WHERE bar =' + id, (rows, fields) => {

    if (rows.length !== 1) {

        throw Object.assign(new Error("User not found."), { custom: true })

    } else {

        return rows[0];

    }

}