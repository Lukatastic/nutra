from flask import Flask, request, jsonify
import pandas as pd
import joblib
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import OneHotEncoder

app = Flask(__name__)


def predict_pest(new_data):
    trained_model = joblib.load('model.pkl')

    country = joblib.load('countryCode.pkl')
    item = joblib.load('itemCode.pkl')

    # print(country[new_data[0]])

    # new_data['Area'] = new_data['Area'].map(country)
    # new_data['Item'] = new_data['Item'].map(item)
    new_data['Area'] = country[new_data['Area']]
    new_data['Item'] = item[new_data['Item']]


    prediction = trained_model.predict(new_data)

    #send = requests.post('https://nutra.kintone.com/k/v1/record.json', headers = {
#     'X-Cybozu-API-Token': 'z2aJ72ON4zXDTFHzkudHaNqCY8CFJyW0AHyF8nUi'
# })

    # results = pd.DataFrame({'prediction': prediction})

    # results.to_csv('results.csv', index=False)

    return prediction


@app.route('/predict', methods=['POST'])
def api():
    data = request.get_json()  # Get JSON data from the client

    prediction = predict_pest(data)
    processed_data = {"prediction": prediction}

    return jsonify(processed_data)  # Return a JSON response

if __name__ == '__main__':
    app.run(debug=True)