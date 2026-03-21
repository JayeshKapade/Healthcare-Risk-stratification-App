import streamlit as st
import pandas as pd
import joblib

model = joblib.load("model.pkl")

st.title ("Healthcare Risk Stratification App")
Age = st.number_input("Age", min_value = 0)
Length_of_stay = st.number_input("Length of stay", min_value = 0)
Treatment_cost = st.number_input("Treatment Cost", min_value = 0)

if st.button("Predict"):
    input_data = pd.DataFrame([[Age, Length_of_stay, Treatment_cost]],
                          columns=['Age', 'LengthOfStay', 'TreatmentCost'])
    prediction = model.predict(input_data)[0]
    probability = model.predict_proba(input_data)[0][1]
    if prob > 0.65:
        prediction = "High Risk"
    else:
        prediction = "Low Risk"

    st.write(f"Risk Prediction: {prediction}")
    st.write(f"Risk Probability: {round(probability, 2)}")
