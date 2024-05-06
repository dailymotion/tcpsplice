FROM golang:1.22-alpine
RUN apk add make upx
COPY ./ ./
RUN make
RUN cp tcpsplice /bin/tcpsplice
FROM scratch
COPY --from=0 /bin/tcpsplice /bin/tcpsplice
EXPOSE 443
CMD [ "/bin/tcpsplice" ]
