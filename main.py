from fastapi import FastAPI
from transformers import pipeline

import torch

# Create a new FastAPI app instance
app = FastAPI()
 
# Initialize the text generation pipeline
# This function will be able to generate text
# given an input.
pipe = pipeline("text2text-generation", 
model="google/flan-t5-small")


@app.get("/spec")
def spec():
    """
    Display the GPU spec if any.
    """
    device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")
    return {"output" : device.type}

@app.get("/generate")
def generate(text: str):
    """
    Using the text2text-generation pipeline from `transformers`, generate text
    from the given input text. The model used is `google/flan-t5-small`, which
    can be found [here](<https://huggingface.co/google/flan-t5-small>).
    """
    # Use the pipeline to generate text from the given input text
    output = pipe(text)
     
    # Return the generated text in a JSON response
    return {"output": output[0]["generated_text"]}
