from fastapi import FastAPI, HTTPException, Request, Query
from fastapi.middleware.cors import CORSMiddleware
import qrcode
import boto3
from io import BytesIO
import os

# Loading Environment variable (AWS Access Key and Secret Key)
from dotenv import load_dotenv
load_dotenv()
aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")


app = FastAPI()

# Allowing CORS for local testing
origins = [
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_methods=["*"],
    allow_headers=["*"],
)

# AWS S3 Configuration
bucket_name = 'devop-project' # Add your bucket name here
s3 = boto3.client('s3',aws_access_key_id= aws_access_key, aws_secret_access_key=aws_secret_key)
#s3 = boto3.client('s3')


@app.post("/generate-qr/")
async def generate_qr(request: Request ,url: str = Query()):
    
    try:
        # Generate QR Code
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data(url)
        qr.make(fit=True)

        img = qr.make_image(fill_color="black", back_color="white")
        
        # Save QR Code to BytesIO object
        img_byte_arr = BytesIO()
        img.save(img_byte_arr, format='PNG')
        img_byte_arr.seek(0)

        # Generate file name for S3
        file_name = f"qr_codes/{url.split('//')[-1]}.png"

        # Upload to S3
        s3.put_object(Bucket=bucket_name, Key=file_name, Body=img_byte_arr, ContentType='image/png')
        
        # Generate the S3 URL
        s3_url = f"https://{bucket_name}.s3.amazonaws.com/{file_name}"
        return {"qr_code_url": s3_url}
    except Exception as e:
        print(f"Error generating QR code: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Error generating QR code: {str(e)}")