package ibm.sample;

import io.reactivex.Flowable;
import io.vertx.reactivex.core.http.HttpServer;
import io.vertx.reactivex.core.AbstractVerticle;
import io.vertx.reactivex.core.http.HttpServerRequest;
import io.vertx.reactivex.core.Vertx;


public class HelloWorld extends AbstractVerticle {

    @Override
    public void start() {

            final HttpServer server = vertx.createHttpServer();
            final Flowable<HttpServerRequest> requestFlowable = server.requestStream().toFlowable();

            requestFlowable.subscribe(httpServerRequest -> {

                String target = System.getenv("TARGET");
                if (target == null) {
                    target = "NOT SPECIFIED";
                }

                httpServerRequest.response().setChunked(true)
                        .putHeader("content-type", "text/plain")
                        .setStatusCode(200) // OK
                        .end("Hello World: " + target);
            });

            server.listen(8080);
        }

        public static void main(String[] args){
            Vertx.vertx().deployVerticle(HelloWorld.class.getName());
        }
}
