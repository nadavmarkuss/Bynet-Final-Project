FROM python
WORKDIR /app
ENV FLASK_APP=hello.py
ENV FLASK_RUN_HOST=0.0.0.0
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
COPY . .
CMD ["flask", "run"]
