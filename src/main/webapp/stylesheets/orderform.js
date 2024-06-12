
    // Function to update label text for both inputs
    function updateLabel(inputId, labelId) {
        const inputFile = document.getElementById(inputId);
        const fileLabel = document.getElementById(labelId);

        if (inputFile.files.length > 0) {
            fileLabel.textContent = inputFile.files[0].name;
        } else {
            fileLabel.textContent = 'Choose a file';
        }
    }

    // Update label for 'validId' input
    document.getElementById('validId').addEventListener('change', function () {
        updateLabel('validId', 'file-label');
    });

    // Update label for 'receipt' input
    document.getElementById('receipt').addEventListener('change', function () {
        updateLabel('receipt', 'receipt-label');
    });

    // Ensure the "Choose a file" label shows initially
    document.addEventListener('DOMContentLoaded', function () {
        updateLabel('validId', 'file-label');
        updateLabel('receipt', 'receipt-label');
    });


//city
     function updateCities() {
        const regionSelect = document.getElementById("region");
        const citySelect = document.getElementById("city");
        const region = regionSelect.value;

        // Clear the current options
        citySelect.innerHTML = '<option value="">Select a city</option>';

        const citiesByRegion = {
            "NCR": [
                "Caloocan City", "Las Piñas City", "Makati City", "Malabon City", "Mandaluyong City", 
                "Manila City", "Marikina City", "Muntinlupa City", "Navotas City", "Parañaque City", 
                "Pasay City", "Pasig City", "Quezon City", "San Juan City", "Taguig City", "Valenzuela City"
            ],
            "Region I": [
                "Batac City", "Laoag City", "Candon City", "Vigan City", "San Fernando City", 
                "Alaminos City", "Dagupan City", "San Carlos City", "Urdaneta City"
            ],
            "Region II": [
                "Tuguegarao City", "Cauayan City", "Ilagan City", "Santiago City"
            ],
            "Region III": [
                "Balanga City", "Malolos City", "Meycauayan City", "San Jose del Monte City", 
                "Cabanatuan City", "Gapan City", "Muñoz City", "Palayan City", "Angeles City", 
                "Mabalacat City", "San Fernando City", "Tarlac City", "Olongapo City", "San Jose City"
            ],
            "Region IV-A": [
                "Batangas City", "Lipa City", "Tanauan City", "Bacoor City", "Cavite City", 
                "Dasmariñas City", "Imus City", "Tagaytay City", "Trece Martires City", "Biñan City", 
                "Cabuyao City", "San Pablo City", "Santa Rosa City", "Lucena City", "Tayabas City", 
                "Antipolo City", "Calamba City"
            ],
            "MIMAROPA": [
                "Calapan City", "Puerto Princesa City"
            ],
            "Region V": [
                "Legazpi City", "Ligao City", "Tabaco City", "Iriga City", "Naga City", 
                "Masbate City", "Sorsogon City"
            ],
            "Region VI": [
                "Roxas City", "Iloilo City", "Passi City", "Bacolod City", "Bago City", 
                "Cadiz City", "Escalante City", "Himamaylan City", "Kabankalan City", 
                "La Carlota City", "Sagay City", "San Carlos City", "Silay City", "Sipalay City", 
                "Talisay City", "Victorias City"
            ],
            "Region VII": [
                "Tagbilaran City", "Bogo City", "Carcar City", "Cebu City", "Danao City", 
                "Lapu-Lapu City", "Mandaue City", "Naga City", "Talisay City", "Bais City", 
                "Bayawan City", "Canlaon City", "Dumaguete City", "Guihulngan City", "Tanjay City", 
                "Toledo City"
            ],
            "Region VIII": [
                "Borongan City", "Baybay City", "Ormoc City", "Tacloban City", 
                "Calbayog City", "Catbalogan City", "Maasin City"
            ],
            "Region IX": [
                "Isabela City", "Dapitan City", "Dipolog City", "Pagadian City", "Zamboanga City"
            ],
            "Region X": [
                "Malaybalay City", "Valencia City", "Iligan City", "Oroquieta City", "Ozamiz City", 
                "Tangub City", "Cagayan de Oro City", "El Salvador City", "Gingoog City"
            ],
            "Region XI": [
                "Panabo City", "Samal City", "Tagum City", "Davao City", "Digos City", "Mati City"
            ],
            "Region XII": [
                "Kidapawan City", "Cotabato City", "General Santos City", "Koronadal City", "Tacurong City"
            ],
            "Region XIII": [
                "Butuan City", "Cabadbaran City", "Bayugan City", "Surigao City", "Bislig City", "Tandag City"
            ],
            "CAR": [
                "Baguio City", "Tabuk City"
            ],
            "BARMM": [
                "Lamitan City", "Marawi City"
            ]
        };

        if (region in citiesByRegion) {
            citiesByRegion[region].forEach(city => {
                const option = document.createElement("option");
                option.value = city;
                option.textContent = city;
                citySelect.appendChild(option);
            });
        }
    }