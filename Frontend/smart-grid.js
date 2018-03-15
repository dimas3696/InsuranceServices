var smartgrid = require('smart-grid');
 
var settings = {
    outputStyle: 'less',
    columns: 24, 
    offset: '30px',
    mobileFirst: false, 
    container: {
        maxWidth: '1200px', /* max-width оn very large screen */
        fields: '30px' /* side fields */
    },
    breakPoints: {
        lg: {
            width: '1300px', /* -> @media (max-width: 1100px) */
        },
        md: {
            width: '960px'
        },
        sm: {
            width: '780px',
            fields: '15px' /* set fields only if you want to change container.fields */
        },
        xs: {
            width: '560px'
        }
      
    }
};
 
smartgrid('./src/precss', settings);