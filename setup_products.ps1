# Firebase Products Database Setup - PowerShell Script
# This adds all products to Firestore

# Configuration
$PROJECT_ID = "pethub-app-a0f7a"
$FIRESTORE_URL = "https://firestore.googleapis.com/v1/projects/$PROJECT_ID/databases/(default)/documents"

Write-Host "============================================" -ForegroundColor Green
Write-Host "PetHub - Adding Products to Firestore" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# NOTE: This requires Firebase authentication
# You need to either:
# 1. Use Firebase Admin SDK (requires service account key)
# 2. Use Firebase CLI (easier method)

Write-Host "EASIEST METHOD: Using Firebase CLI" -ForegroundColor Yellow
Write-Host ""
Write-Host "Step 1: Install Firebase CLI" -ForegroundColor Cyan
Write-Host "  npm install -g firebase-tools"
Write-Host ""
Write-Host "Step 2: Login to Firebase" -ForegroundColor Cyan
Write-Host "  firebase login"
Write-Host ""
Write-Host "Step 3: Run this command from project root:" -ForegroundColor Cyan
Write-Host "  firebase firestore:import products_backup.json"
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# Alternative: Manual import via Firebase Console (see instructions below)
Write-Host "ALTERNATIVE: Manual Method via Firebase Console" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/data" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Click '+ Start collection' and name it: products" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Add each product document manually with these fields:" -ForegroundColor Cyan
Write-Host ""
Write-Host "Category: Toys" -ForegroundColor Magenta
Write-Host "  - Pedigree 10kg (Rs 2490)" -ForegroundColor Cyan
Write-Host "  - PedigreePro 1.2kg (Rs 458)" -ForegroundColor Cyan
Write-Host "  - Henlo Dry (Rs 39)" -ForegroundColor Cyan
Write-Host "  - Royal Canin (Rs 990)" -ForegroundColor Cyan
Write-Host "  - Canine Greek (Rs 684)" -ForegroundColor Cyan
Write-Host "  - Dog Bikkit (Rs 320)" -ForegroundColor Cyan
Write-Host "  - Puppy Snacks (Rs 250)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Category: Clothes" -ForegroundColor Magenta
Write-Host "  - Woven Dress (Rs 684)" -ForegroundColor Cyan
Write-Host "  - Pet Shirt (Rs 450)" -ForegroundColor Cyan
Write-Host "  - Pet Sweater (Rs 750)" -ForegroundColor Cyan
Write-Host "  - Pet Raincoat (Rs 1200)" -ForegroundColor Cyan
Write-Host "  - Pet Jacket (Rs 900)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Category: Food" -ForegroundColor Magenta
Write-Host "  - Pedigree 10kg (Rs 2490)" -ForegroundColor Cyan
Write-Host "  - PedigreePro 1.2kg (Rs 458)" -ForegroundColor Cyan
Write-Host "  - Henlo Dry (Rs 39)" -ForegroundColor Cyan
Write-Host "  - Royal Canin (Rs 990)" -ForegroundColor Cyan
Write-Host "  - Canine Greek (Rs 684)" -ForegroundColor Cyan
Write-Host "  - Dog Bikkit (Rs 320)" -ForegroundColor Cyan
Write-Host "  - Puppy Snacks (Rs 250)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Category: Medicine" -ForegroundColor Magenta
Write-Host "  - Alfalfa tonic (Rs 250)" -ForegroundColor Cyan
Write-Host "  - Diarrhoea tablets (Rs 90)" -ForegroundColor Cyan
Write-Host "  - Drop for excessive thirst (Rs 100)" -ForegroundColor Cyan
Write-Host "  - Ear drop (Rs 130)" -ForegroundColor Cyan
Write-Host "  - Wound lotion (Rs 684)" -ForegroundColor Cyan
Write-Host "  - Joint Tablets (Rs 180)" -ForegroundColor Cyan
Write-Host "  - Liv 52 metabolism (Rs 350)" -ForegroundColor Cyan
Write-Host "  - Multivitamin for pets (Rs 350)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Category: Accessories" -ForegroundColor Magenta
Write-Host "  - Mouth Cover muzzles (Rs 2490)" -ForegroundColor Cyan
Write-Host "  - Hair Brush (Rs 450)" -ForegroundColor Cyan
Write-Host "  - Portable Bed (Rs 1800)" -ForegroundColor Cyan
Write-Host "  - Dog Harness (Rs 990)" -ForegroundColor Cyan
Write-Host "  - Dog leash (Rs 340)" -ForegroundColor Cyan
Write-Host "  - Retractable Dog Leash (Rs 720)" -ForegroundColor Cyan
Write-Host "  - Food Bowl 700ml (Rs 270)" -ForegroundColor Cyan
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
