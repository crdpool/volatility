cd ./allora-l2 && FILE="enhanced_bilstm_model_validation.pth" && curl -L http://185.197.251.70/model/$FILE -o $FILE && docker compose up -d --build
