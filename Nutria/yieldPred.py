import pandas as pd
import joblib, requests
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import OneHotEncoder


def train_model():

    data = pd.read_csv('yield_df.csv')

    country_to_number = {area: i for i, area in enumerate(data['Area'].unique(), 1)}

    item_to_number = {item: i for i, item in enumerate(data['Item'].unique(), 1)}

    joblib.dump(country_to_number, 'countryCode.pkl')
    joblib.dump(item_to_number, 'itemCode.pkl')



    data['Area'] = data['Area'].map(country_to_number)
    data['Item'] = data['Item'].map(item_to_number)

    label = data['pesticides_tonnes']
    features = data.drop(columns=['Unnamed: 0', 'Year', 'pesticides_tonnes'])

    X_train, X_test, y_train, y_test = train_test_split(features, label, test_size=0.2, random_state=42)

    rf_regressor = RandomForestRegressor()

    rf_regressor.fit(X_train, y_train)

    y_pred = rf_regressor.predict(X_test)

    mse = mean_squared_error(y_test, y_pred)
    print("Mean Squared Error:", mse)

    joblib.dump(rf_regressor, 'model.pkl')


#swift/kintone pass in new_data
def predict_pest(new_data):
    trained_model = joblib.load('model.pkl')

    country = joblib.load('countryCode.pkl')
    item = joblib.load('itemCode.pkl')

    # new_data['Area'] = new_data['Area'].map(country)
    # new_data['Item'] = new_data['Item'].map(item)
    new_data[0] = new_data[0].map(country)
    new_data[1] = new_data[1].map(item)


    prediction = trained_model.predict(new_data)

#     send = requests.post('https://nutra.kintone.com/k/v1/record.json', headers = {
#     'X-Cybozu-API-Token': 'z2aJ72ON4zXDTFHzkudHaNqCY8CFJyW0AHyF8nUi'
# })

    # results = pd.DataFrame({'prediction': prediction})

    # results.to_csv('results.csv', index=False)

    return prediction


# def main():
#     train_model()

#     new_data = pd.read_csv('new_data.csv')
#     ###
#     #predict_pest(new_data)
#     ###KINTONE CALL START
#     kt_data = requests.post(

#     )
#     ###KINTONE CALL END



if __name__ == "__main__":
    main()