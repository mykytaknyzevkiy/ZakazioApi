FROM node:12.13.0-alpine
RUN mkdir -p /opt/app
WORKDIR /opt/app
RUN adduser -S app
COPY ./ .
RUN npm install
RUN chown -R app /opt/app
USER app

RUN npm run build

EXPOSE 3737

# set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0
# set app port
ENV NUXT_PORT=3737

CMD [ "npm", "start" ]
