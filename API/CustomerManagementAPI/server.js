const app = require('./index');
const config = require('./util/config');

app.listen(config.hostPORT, (err) => {
    if (err) throw err
    console.log('Server running in http://' + config.hostIP + ':' + config.hostPORT);
});