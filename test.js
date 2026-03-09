fetch('https://labloom.onrender.com/api/patients/doctors')
    .then(r => r.json())
    .then(data => {
        if (data.doctors && data.doctors.length > 0) {
            const docId = data.doctors[0]._id || data.doctors[0].id;
            return fetch('https://labloom.onrender.com/api/patients/doctors/' + docId + '/slots?date=2026-03-09');
        }
    })
    .then(r => r ? r.json() : null)
    .then(slots => {
        if (slots) {
            console.log("Slots Response with date:", JSON.stringify(slots, null, 2));
        }
    })
    .catch(console.error);

fetch('https://labloom.onrender.com/api/patients/doctors')
    .then(r => r.json())
    .then(data => {
        if (data.doctors && data.doctors.length > 0) {
            const docId = data.doctors[0]._id || data.doctors[0].id;
            return fetch('https://labloom.onrender.com/api/patients/doctors/' + docId + '/slots');
        }
    })
    .then(r => r ? r.json() : null)
    .then(slots => {
        if (slots) {
            console.log("Slots Response without date:", JSON.stringify(slots, null, 2));
        }
    })
    .catch(console.error);
